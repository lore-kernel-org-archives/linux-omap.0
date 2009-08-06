From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [RFC][PATCH v2 4/4] OMAP4: PMIC: Update TWL mfd driver to
 create twl6030 regulators
Date: Thu, 6 Aug 2009 09:11:34 +0100
Message-ID: <20090806081133.GA6438@rakim.wolfsonmicro.main>
References: <1248842173-21821-1-git-send-email-balajitk@ti.com>
 <20090803142356.GA4265@rakim.wolfsonmicro.main>
 <20090804074544.GG24334@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B5CD8884@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301D8BD1708@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B5CD8BFF@dbde02.ent.ti.com>
 <20090804134247.GA32353@rakim.wolfsonmicro.main>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B5CD8C25@dbde02.ent.ti.com>
 <20090805213932.GD20853@opensource.wolfsonmicro.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B5D8155B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B5D8155B-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: "Premi, Sanjeev" <premi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Krishnamoorthy, Balaji T" <balajitk-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org" <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org" <sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org>, "wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org" <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, "timo.t.kokkonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <timo.t.kokkonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org" <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, "Nayak, Rajendra" <rnayak-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 06, 2009 at 12:57:26PM +0530, Shilimkar, Santosh wrote:

> So what you suggest here. 

Some of the earlier names like twl_is_*() seemed OK; given that the
driver is called twl everywhere I don't see much problem with the tps
variants using that scheme too.
