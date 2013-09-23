From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC PATCH 08/15] ata: ahci_platform: Manage SATA PHY
Date: Mon, 23 Sep 2013 16:59:59 +0400
Message-ID: <52403B4F.3070406@cogentembedded.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com> <1379595943-14622-9-git-send-email-rogerq@ti.com> <20130922165817.GD30946@htj.dyndns.org> <523F35E4.6050707@cogentembedded.com> <20130922215107.GD27616@mtj.dyndns.org> <523FEFC2.801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <523FEFC2.801-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 23-09-2013 11:37, Roger Quadros wrote:

>>>     Not sure why you asked -- I'm not using this driver, neither I'm

>> Well, you have better grip of what's going on in the embedded world
>> than me.  I'm mostly curious whether adding dependency on PHY is okay.

> There is no hard dependency on presence of PHY. The driver will continue
> as usual if devm_phy_get() fails.
> I hope selecting GENERIC_PHY in Kconfig is not an issue.

    Selecting in the AHCI_PLATFORM section? It seems I have overlooked it. No, 
I don't think it's a good idea. The generic PHY functions seem to be stubbed 
when GENERIC_PHY=n.

> cheers,
> -roger

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
