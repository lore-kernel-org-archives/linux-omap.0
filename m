From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] power_supply: Add driver for TWL4030/TPS65950 BCI
 charger
Date: Mon, 30 Nov 2009 21:58:13 +0300
Message-ID: <20091130185813.GA32522@oksana.dev.rtsoft.ru>
References: <1259333060-24277-1-git-send-email-notasas@gmail.com>
 <012301ca71ed$449cb930$544ff780@am.dhcp.ti.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753155AbZK3S6J@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <012301ca71ed$449cb930$544ff780@am.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: 'Grazvydas Ignotas' <notasas@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 30, 2009 at 12:45:20PM -0600, Madhusudhan wrote:
[...]
> > +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> > +		/* charging must be active for meaningful result */
> > +		if (!is_charging) {
> 
> How about putting a kern_info here?

It might be better to return -EINVAL.

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
