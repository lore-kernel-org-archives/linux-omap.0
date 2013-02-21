From: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Subject: Re: [PATCH 0/6] Introducing Device Tree Overlays
Date: Thu, 21 Feb 2013 13:53:04 -0800
Message-ID: <3A37C4DA-4D4D-4370-8305-15625B923E67@antoniou-consulting.com>
References: <1357327870-13615-1-git-send-email-panto@antoniou-consulting.com>
 <CANk1AXQ7ajnwTaHwwbyrri2YkX_60uC9xrQYWuR8u4eT2EQsew@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CANk1AXQ7ajnwTaHwwbyrri2YkX_60uC9xrQYWuR8u4eT2EQsew-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: delicious quinoa <delicious.quinoa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Alan,

On Feb 21, 2013, at 1:25 PM, delicious quinoa wrote:

> I like where this is heading.  I'm interested in a use case where IP
> can be loaded into a FPGA, then add a blob to the device tree and load
> some drivers.
> 
> I see your github tree.  If I wanted to cherry-pick your code and play
> around with it, which branch should I use?  not-capebus-21?
> 

not-capebus-v21 is the latest one and indeed that has it in.

Please note that I had some other FPGA people interested with it.
Perhaps we can go through use cases to come up with your requirements


> Thanks,
> Alan Tull
> Altera Corp
> 

Regards

-- Pantelis

> On Fri, Jan 4, 2013 at 1:31 PM, Pantelis Antoniou
> <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org> wrote:
>> The following patchset introduces Device Tree overlays, a method
>> of dynamically altering the kernel's live Device Tree.
>> 
>> This patchset is against mainline as of Friday Jan 4 2013.
>> (4956964 Merge tag 'driver-core-3.8-rc2' of \
>>        git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core)
>> 
>> Note that a separate patch for the DTC compiler has been posted and
>> is required to compile the DTS files according to the documentation.
>> The patch is "dtc: Dynamic symbols & fixup support"
>> 
>> An implementation patchset for a beaglebone cape loader will follow,
>> but if you want to check out a working kernel for the beaglebone please
>> pull from:
>> 
>> git://github.com/pantoniou/linux-bbxm.git branch not-capebus-v8
>> 
>> Pantelis Antoniou (6):
>>  OF: Introduce device tree node flag helpers.
>>  OF: export of_property_notify
>>  OF: Export all DT proc update functions
>>  OF: Introduce utility helper functions
>>  OF: Introduce Device Tree resolve support.
>>  OF: Introduce DT overlay support.
>> 
>> .../devicetree/dynamic-resolution-notes.txt        |  25 +
>> Documentation/devicetree/overlay-notes.txt         | 179 +++++
>> drivers/of/Kconfig                                 |  19 +
>> drivers/of/Makefile                                |   4 +-
>> drivers/of/base.c                                  | 114 +--
>> drivers/of/overlay.c                               | 831 +++++++++++++++++++++
>> drivers/of/resolver.c                              | 394 ++++++++++
>> drivers/of/util.c                                  | 253 +++++++
>> include/linux/of.h                                 | 243 ++++++
>> 9 files changed, 2005 insertions(+), 57 deletions(-)
>> create mode 100644 Documentation/devicetree/dynamic-resolution-notes.txt
>> create mode 100644 Documentation/devicetree/overlay-notes.txt
>> create mode 100644 drivers/of/overlay.c
>> create mode 100644 drivers/of/resolver.c
>> create mode 100644 drivers/of/util.c
>> 
>> --
>> 1.7.12
>> 
>> _______________________________________________
>> devicetree-discuss mailing list
>> devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
>> https://lists.ozlabs.org/listinfo/devicetree-discuss
