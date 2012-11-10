From: Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] Device Tree Overlays Proposal (Was Re: capebus moving
 omap_devices to mach-omap2)
Date: Fri, 9 Nov 2012 21:36:26 -0600
Message-ID: <CAD=GYpZwpRRUD=Qy529KkiL-5e2zHaCWMZM9+CTQEnMqSR3yEw@mail.gmail.com>
References: <CACxGe6vu8ek7-K-yDDMXyg9x-oKiFt_cSz+Pz-yZf5U5vwe=0g@mail.gmail.com>
 <02FF5400-9F97-4B8A-AEF0-267B01C8099F@antoniou-consulting.com>
 <-4237940489086529028@unknownmsgid>
 <559B8433-67C3-4A1A-A5D6-859907655176@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <559B8433-67C3-4A1A-A5D6-859907655176-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Deepak Saxena <dsaxena-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Pantelis,

On Fri, Nov 9, 2012 at 2:13 AM, Pantelis Antoniou
<panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org> wrote:

>>>> Option C: U-Boot loads both the base and overlay FDT files, merges them,
>>>>       and passes the resolved tree to the kernel.
>>>>
>>>
>>> Could be made to work. Only really required if Joanne wants the
>>> cape interface to work for u-boot too. For example if the cape has some
>>> kind of network interface that u-boot will use to boot from.
>>>
>>
>> I love Grant's hashing idea a lot keeping the phandle problem for
>> compile time and not requiring fixups.
>>
>> IMO it is still a cleaner approach if u-boot does the tree merging for
>> all cases, and not the kernel.
>>
>> That way from a development standpoint, very little or nothing will
>> have to be changed in kernel (except for scripts/dtc) considering we
>> are moving forward with hashing.
>>
>> Also this discussed a while back but at some point is going to brought
>> up again-  loading of dt fragment directly from EEPROM and merging at
>> run time. If we were to implement this in kernel, we would have to add
>> cape specific EEPROM reading code, merge the tree before it is
>> unflattened and parse. I think doing tree merging in kernel is messy
>> and we should do it in uboot. Ideally reading the fragment from the
>> EEPROM for all capes and merging without worrying about version
>> detection, Doing the merge and passing the merged blob to the kernel
>> which (kernel) works the same way it does today.
>
> Not going to work, for a lot of cases. Doing it in the kernel seems to be
> the cleaner option. There are valid use cases for doing in u-boot too.

True, if dynamic runtime stuff from userspace is what we're talking
about, then yeah I see the important need for kernel to do the merge.

>> Alternatively to hashing, reading david gibsons paper I followed,
>> phandle is supposed to 'uniquely' identity node. I wonder why the node
>> name itself is not sufficient to unquiely identify. The code that does
>> the tree walking can then just strcmp the node name while it walks the
>> tree instead of having to find a node with a phandle number. I guess
>> the reason is phandles are small to store as data values. Another
>> approach can be to arrange the string block in alphabetical order
>> (unless it already is), and store phandle as index of the node name
>> referenced relative to the starting of the strong block. This will not
>> affect nodes in dtb being moved around since they will still have the
>> same index value. the problem being adding or removing nodes Changes
>> the offsets of all other nodes in the string block as well.. Hmm.
>>
>
> This is pretty radical change to the DT format, no?

Yes, true and the only way hypothetically to replace the phandle
tree-walking mechanism is to store node paths instead of phandle which
David pointed is too long to store, so I guess this wont work after
all. Anyway this was an interesting exercise, thanks.

Regards,
Joel
