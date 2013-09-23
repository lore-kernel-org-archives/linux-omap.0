From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC PATCH 08/15] ata: ahci_platform: Manage SATA PHY
Date: Mon, 23 Sep 2013 10:37:38 +0300
Message-ID: <523FEFC2.801@ti.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com> <1379595943-14622-9-git-send-email-rogerq@ti.com> <20130922165817.GD30946@htj.dyndns.org> <523F35E4.6050707@cogentembedded.com> <20130922215107.GD27616@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130922215107.GD27616@mtj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, balbi@ti.com, bcousson@baylibre.com, tony@atomide.com, balajitk@ti.com, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tejun,

On 09/23/2013 12:51 AM, Tejun Heo wrote:
> Hello,
> 
> On Sun, Sep 22, 2013 at 10:24:36PM +0400, Sergei Shtylyov wrote:
>>    Not sure why you asked -- I'm not using this driver, neither I'm
> 
> Well, you have better grip of what's going on in the embedded world
> than me.  I'm mostly curious whether adding dependency on PHY is okay.
> 

There is no hard dependency on presence of PHY. The driver will continue
as usual if devm_phy_get() fails.
I hope selecting GENERIC_PHY in Kconfig is not an issue.

cheers,
-roger
