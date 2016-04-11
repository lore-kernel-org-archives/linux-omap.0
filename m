From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 08/10] usb: dwc3: core: fix PHY handling during suspend
Date: Mon, 11 Apr 2016 16:13:28 +0300
Message-ID: <570BA2F8.3000503@ti.com>
References: <1460374506-9779-1-git-send-email-rogerq@ti.com>
 <1460374506-9779-9-git-send-email-rogerq@ti.com> <8760vonxin.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8760vonxin.fsf-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/04/16 15:24, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>> From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>
>> we need to power off the PHY during suspend and
>> power it back on during resume.
>>
>> Signed-off-by: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> [nsekhar-l0cyMroinI0@public.gmane.org: fix call to usb_phy_set_suspend() in dwc3_suspend()]
>> Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> 
> is this also a fix which needs to be rebased on v4.6-rc3 and merged
> during current -rc cycle ?
> 
Yes, I'll post it separately.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
