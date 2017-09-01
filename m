From: Suman Anna via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/omap: Add support to program multiple iommus
Date: Fri, 1 Sep 2017 11:21:45 -0500
Message-ID: <d8b503a1-eaff-e4cc-215d-92520a91e205@ti.com>
References: <20170831131402.29502-1-s-anna@ti.com>
	<20170831131402.29502-3-s-anna@ti.com>
	<20170901100141.2ooccy7ns2fwxceg@8bytes.org>
Reply-To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170901100141.2ooccy7ns2fwxceg-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Joerg,

On 09/01/2017 05:01 AM, Joerg Roedel wrote:
> Hi Suman,
> 
> On Thu, Aug 31, 2017 at 08:14:02AM -0500, Suman Anna wrote:
>> The OMAP IOMMU driver has been enhanced to support allowing
>> multiple IOMMUs to be programmed by a single client user. This
>> support is being added mainly to handle the DSP subsystems on
>> the DRA7xx SoCs, which have two MMUs within the same subsystem.
>> These MMUs provide translations to a processor core port and
>> an internal EDMA port. This support allows both the MMUs to
>> be programmed together, but with each one retaining it's own
>> internal state objects. The internal EDMA is managed by the
>> software running on the DSPs, and this design provides on-par
>> functionality with previous generation OMAP DSPs where the
>> EDMA and the DSP core shared the same MMU.
> 
> I didn't get that from the review, so a question here: Do both MMUs show
> show up in sysfs, means, do you register both of them the the core code?

Yes, both MMUs are identical instances of the IP, and both are
represented as their own platform devices (unique DT nodes), and since
we created the iommu_group in probe of each device, each MMU has its own
iommu_group as well.

Here's a bit more output,

root@dra7xx-evm:~# dmesg | grep mmu
[    0.519087] omap-iommu 40d01000.mmu: 40d01000.mmu registered
[    0.519580] omap-iommu 40d02000.mmu: 40d02000.mmu registered
[    0.520050] omap-iommu 58882000.mmu: 58882000.mmu registered
[    0.520495] omap-iommu 55082000.mmu: 55082000.mmu registered
[    0.521145] omap-iommu 41501000.mmu: 41501000.mmu registered
[    0.521634] omap-iommu 41502000.mmu: 41502000.mmu registered
[    0.522100] iommu: Adding device 58820000.ipu to group 2
[    0.522260] iommu: Adding device 55020000.ipu to group 3
[    0.522520] iommu: Adding device 40800000.dsp to group 0
[    0.522955] iommu: Adding device 41000000.dsp to group 4
root@dra7xx-evm:~# ls -l /sys/class/iommu/
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 40d01000.mmu ->
../../devices/platform/44000000.ocp/40d01000.mmu/iommu/40d01000.mmu
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 40d02000.mmu ->
../../devices/platform/44000000.ocp/40d02000.mmu/iommu/40d02000.mmu
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 41501000.mmu ->
../../devices/platform/44000000.ocp/41501000.mmu/iommu/41501000.mmu
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 41502000.mmu ->
../../devices/platform/44000000.ocp/41502000.mmu/iommu/41502000.mmu
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 55082000.mmu ->
../../devices/platform/44000000.ocp/55082000.mmu/iommu/55082000.mmu
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 58882000.mmu ->
../../devices/platform/44000000.ocp/58882000.mmu/iommu/58882000.mmu

> Because I think with the solution implemented here, only a single,
> combined MMU should be visible to iommu core code and in sysfs.

So, the way I have implemented atm is to do the device linking only to
one MMU in .add_device ops, while most of the remaining ops like map,
unmap, attach_device, detach_device loop through both MMUs to do the
programming.

It's primarily a question of whether each iommu platform device need to
be represented as a unique iommu_device or not. If you still think that
both these need to be presented to iommu core as one device, I would
have to add some glue logic in probe to tie the two devices together.

regards
Suman
