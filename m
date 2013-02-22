From: delicious quinoa <delicious.quinoa@gmail.com>
Subject: Re: [PATCH 0/6] Introducing Device Tree Overlays
Date: Fri, 22 Feb 2013 09:57:39 -0600
Message-ID: <CANk1AXTji0CB8jsdTRg0+u56m_BiVoBQHaPQzHKoSA3Tr68ZEw@mail.gmail.com>
References: <1357327870-13615-1-git-send-email-panto@antoniou-consulting.com>
	<CANk1AXQ7ajnwTaHwwbyrri2YkX_60uC9xrQYWuR8u4eT2EQsew@mail.gmail.com>
	<3A37C4DA-4D4D-4370-8305-15625B923E67@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <3A37C4DA-4D4D-4370-8305-15625B923E67@antoniou-consulting.com>
Sender: linux-doc-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: linux-doc@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Russ Dill <Russ.Dill@ti.com>, Matt Porter <mporter@ti.com>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>, linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Joel A Fernandes <agnel.joel@gmail.com>
List-Id: linux-omap@vger.kernel.org

Our use case is partial reconfiguration of the FPGA.  This will be
driven from userspace, so the bitstream to program the FPGA will come
from userspace, then the overlay for the DT, also from userspace.

So we want to take a compiled partial device tree and simply 'cat' it
to a point under /proc, such as 'cat new-ip.dtb > /proc/device-tree'

Alan Tull
Altera Corp.

On Thu, Feb 21, 2013 at 3:53 PM, Pantelis Antoniou
<panto@antoniou-consulting.com> wrote:
> Hi Alan,
>
> On Feb 21, 2013, at 1:25 PM, delicious quinoa wrote:
>
>> I like where this is heading.  I'm interested in a use case where IP
>> can be loaded into a FPGA, then add a blob to the device tree and load
>> some drivers.
>>
>> I see your github tree.  If I wanted to cherry-pick your code and play
>> around with it, which branch should I use?  not-capebus-21?
>>
>
> not-capebus-v21 is the latest one and indeed that has it in.
>
> Please note that I had some other FPGA people interested with it.
> Perhaps we can go through use cases to come up with your requirements
>
>
>> Thanks,
>> Alan Tull
>> Altera Corp
>>
>
> Regards
>
> -- Pantelis
>
>> On Fri, Jan 4, 2013 at 1:31 PM, Pantelis Antoniou
>> <panto@antoniou-consulting.com> wrote:
>>> The following patchset introduces Device Tree overlays, a method
>>> of dynamically altering the kernel's live Device Tree.
>>>
>>> This patchset is against mainline as of Friday Jan 4 2013.
>>> (4956964 Merge tag 'driver-core-3.8-rc2' of \
>>>        git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core)
>>>
>>> Note that a separate patch for the DTC compiler has been posted and
>>> is required to compile the DTS files according to the documentation.
>>> The patch is "dtc: Dynamic symbols & fixup support"
>>>
>>> An implementation patchset for a beaglebone cape loader will follow,
>>> but if you want to check out a working kernel for the beaglebone please
>>> pull from:
>>>
>>> git://github.com/pantoniou/linux-bbxm.git branch not-capebus-v8
>>>
>>> Pantelis Antoniou (6):
>>>  OF: Introduce device tree node flag helpers.
>>>  OF: export of_property_notify
>>>  OF: Export all DT proc update functions
>>>  OF: Introduce utility helper functions
>>>  OF: Introduce Device Tree resolve support.
>>>  OF: Introduce DT overlay support.
>>>
>>> .../devicetree/dynamic-resolution-notes.txt        |  25 +
>>> Documentation/devicetree/overlay-notes.txt         | 179 +++++
>>> drivers/of/Kconfig                                 |  19 +
>>> drivers/of/Makefile                                |   4 +-
>>> drivers/of/base.c                                  | 114 +--
>>> drivers/of/overlay.c                               | 831 +++++++++++++++++++++
>>> drivers/of/resolver.c                              | 394 ++++++++++
>>> drivers/of/util.c                                  | 253 +++++++
>>> include/linux/of.h                                 | 243 ++++++
>>> 9 files changed, 2005 insertions(+), 57 deletions(-)
>>> create mode 100644 Documentation/devicetree/dynamic-resolution-notes.txt
>>> create mode 100644 Documentation/devicetree/overlay-notes.txt
>>> create mode 100644 drivers/of/overlay.c
>>> create mode 100644 drivers/of/resolver.c
>>> create mode 100644 drivers/of/util.c
>>>
>>> --
>>> 1.7.12
>>>
>>> _______________________________________________
>>> devicetree-discuss mailing list
>>> devicetree-discuss@lists.ozlabs.org
>>> https://lists.ozlabs.org/listinfo/devicetree-discuss
>
