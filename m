From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC PATCH 08/15] ata: ahci_platform: Manage SATA PHY
Date: Mon, 23 Sep 2013 16:59:09 +0300
Message-ID: <5240492D.6060204@ti.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com> <1379595943-14622-9-git-send-email-rogerq@ti.com> <20130922165817.GD30946@htj.dyndns.org> <523F35E4.6050707@cogentembedded.com> <20130922215107.GD27616@mtj.dyndns.org> <523FEFC2.801@ti.com> <52403B4F.3070406@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <52403B4F.3070406@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Tejun Heo <tj@kernel.org>, balbi@ti.com, bcousson@baylibre.com, tony@atomide.com, balajitk@ti.com, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/23/2013 03:59 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 23-09-2013 11:37, Roger Quadros wrote:
> 
>>>>     Not sure why you asked -- I'm not using this driver, neither I'm
> 
>>> Well, you have better grip of what's going on in the embedded world
>>> than me.  I'm mostly curious whether adding dependency on PHY is okay.
> 
>> There is no hard dependency on presence of PHY. The driver will continue
>> as usual if devm_phy_get() fails.
>> I hope selecting GENERIC_PHY in Kconfig is not an issue.
> 
>    Selecting in the AHCI_PLATFORM section? It seems I have overlooked it. No, I don't think it's a good idea. The generic PHY functions seem to be stubbed when GENERIC_PHY=n.
> 
OK I will remove the select then.

cheers,
-roger
