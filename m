From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 0/2] Add DRA7xx CPSW Ethernet support in Device Tree
Date: Tue, 21 Oct 2014 12:22:23 -0500
Message-ID: <20141021172223.GA12943@kahuna>
References: <1413885661-4850-1-git-send-email-mugunthanvnm@ti.com>
 <54463063.80207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54463063.80207-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 15:37-20141021, Mugunthan V N wrote:
> Nishanth
> 
> On Tuesday 21 October 2014 03:30 PM, Mugunthan V N wrote:
> > Adding device tree entry for CPSW to make it work in Dual EMAC mode.
> > These patches were tested with DRA7 hwmod patches on top of linux-next.
> > Patches are tested on top of Nishanth's PM tree for v3.17 [1] and pushed
> > my tree to [2].
> > 
> > Did a boot test with CPSW and ping test with suspend/resume, the boot logs
> > on DRA7xx EVM are posted at [3]
> > 
> > [1] git://github.com/nmenon/linux-2.6-playground.git testing/v3.17/cpu-idle-suspend-dra7-omap5-framework
> > [2] git://git.ti.com/~mugunthanvnm/ti-linux-kernel/linux.git v3.17/dra7-evm-cpsw-v3
> > [3] http://pastebin.ubuntu.com/8613072/
> > 
> > Changes from v2:
> > * Changed pinctrl comments to hold mode0-name.mode-selected-name
> > * Changes slave numbers in the pinctrl comments
> > * Added cpsw and cpts clocks
> > 
> 
> I have not added support for dra72x-evm as it has only slave no 2 pinned
> out and having issues with bringing up the interface, need some more
> time to submit the patch, in the mean time I have submitted dra7-evm
> support only so that people can use dra7-evm on linux-next.

Quickly tested as well:
http://slexy.org/raw/s2vISJxYrR

Please feel free to add:
Tested-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Acked-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
