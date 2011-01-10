From: Brad Parker <brad@heeltoe.com>
Subject: Re: UNS: Re: [PATCH] musb: move usb_add_hcd to the core init code
 from gadget code (v2)
Date: Mon, 10 Jan 2011 09:08:17 -0500
Message-ID: <4D2B12D1.5060807@heeltoe.com>
References: <1279895783-7313-1-git-send-email-bryan.wu@canonical.com> <4C600171.5020405@canonical.com> <4D2AF1EE.8010105@heeltoe.com> <20110110115714.GA5573@legolas.emea.dhcp.ti.com> (sfid-20110110_070231_150867_75CADAA4)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110110115714.GA5573@legolas.emea.dhcp.ti.com> (sfid-20110110_070231_150867_75CADAA4)
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: bryan.wu@canonical.com, felipe.balbi@nokia.com, linux-usb@vger.kernel.org, david-b@pacbell.net, kernel-team@lists.ubuntu.com, linux-kernel@vger.kernel.org, ricardo.salveti@canonical.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Felipe Balbi wrote:
> Hi,
>
> On Mon, Jan 10, 2011 at 06:47:58AM -0500, Brad Parker wrote:
>   
>> ...
>> (my expectation is that the mode should toggle from "b_idle" to "a_host"
>> when I plug in an a connector with the id pin tied correctly, and
>> back to "b_idle"
>> when I disconnect)
>>     
> What's the problem in simply insmoding a gadget driver ? If you have OTG
> enabled, you _need_ a gadget driver to have a fully working setup. If
> you want host only, then change Kconfig
I guess there are multiple "modalities".

- some users don't use a gadget driver and expect host mode to work 
(they fail)
- some users use a gadget driver and host mode (apparently that works)
- some users use a gadget driver only (they work)

I'd  like to avoid having multiple kernels.  (and to be honest, I'm not 
convinced
just convince I can get the right behaviors by changing the .config; I 
assume
you mean .config and not Kconfig...  I don't think it works but I'll try 
it out)

-brad
