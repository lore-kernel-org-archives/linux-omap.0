From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 00/24] ARM: OMAP2+: Adapt to ehci-omap changes for 3.10
Date: Wed, 13 Mar 2013 15:41:47 +0200
Message-ID: <5140821B.2030902@ti.com>
References: <1363088606-2692-1-git-send-email-rogerq@ti.com>
 <20130312164007.GZ26093@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130312164007.GZ26093-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
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
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/12/2013 06:40 PM, Tony Lindgren wrote:
> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [130312 04:47]:
>> Hi Tony,
>>
>> These patches provide the SoC side code required to support
>> the changes in the OMAP USB Host drivers done in [1], [2] & [3].
> ... 
> 
>>  arch/arm/mach-omap2/board-3430sdp.c                |   97 +++++++++++++++-
>>  arch/arm/mach-omap2/board-3630sdp.c                |  100 +++++++++++++++-
>>  arch/arm/mach-omap2/board-am3517crane.c            |   95 +++++++++++++--
>>  arch/arm/mach-omap2/board-am3517evm.c              |   66 ++++++++++-
>>  arch/arm/mach-omap2/board-cm-t35.c                 |   95 ++++++++++++++-
>>  arch/arm/mach-omap2/board-cm-t3517.c               |   97 +++++++++++++++-
>>  arch/arm/mach-omap2/board-devkit8000.c             |   20 ++--
>>  arch/arm/mach-omap2/board-generic.c                |   67 +++++++++++
>>  arch/arm/mach-omap2/board-igep0020.c               |  112 ++++++++++++++++---
>>  arch/arm/mach-omap2/board-omap3beagle.c            |   93 +++++++++++++--
>>  arch/arm/mach-omap2/board-omap3evm.c               |   62 ++++++++--
>>  arch/arm/mach-omap2/board-omap3pandora.c           |   52 +++++++--
>>  arch/arm/mach-omap2/board-omap3stalker.c           |   52 +++++++-
>>  arch/arm/mach-omap2/board-omap3touchbook.c         |   62 +++++++++-
>>  arch/arm/mach-omap2/board-omap4panda.c             |  122 ++++++++++++++------
>>  arch/arm/mach-omap2/board-overo.c                  |   54 ++++++++-
>>  arch/arm/mach-omap2/board-zoom.c                   |   56 ++++++++-
> 
> Can't you have some mach-omap2/ehci-common.c that takes care
> of the initializiation to avoid this much addition to the
> board-*.c files? You may be able to have just a common function
> to do it and pass few parameters?

Since we moved reset and power handling for the USB PHYs from omap-echi
driver into the USB PHY driver we need to define the regulator data
for RESET and Power line of each PHY. So most of the code added is just
regulator data for the PHY rather than omap-ehci.

Instead of a common function, I can implement some macros that make it
easier to define the regulators for the PHY in the board files.
Does this sound OK?

Personally I don't like such macros because it hides the implementation
and is difficult to read/debug.

cheers,
-roger
