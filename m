From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] lis3lv02d: Add STMicroelectronics lis33ldlh digital
Date: Wed, 18 Jan 2012 15:43:44 +0100
Message-ID: <20120118154344.4187f461@endymion.delvare>
References: <1324617892-14576-1-git-send-email-anilkumar@ti.com>
	<331ABD5ECB02734CA317220B2BBEABC13177CDA4@DBDE01.ent.ti.com>
	<201201181403.47806.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <201201181403.47806.arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, greg@kroah.com, eric.piel@tremplin-utc.net, akpm@linux-foundation.org, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, "Nori, Sekhar" <nsekhar@ti.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Arnd and all,

The lis3lv02d driver was moved outside of drivers/hwmon to make it
clear that we (hwmon/lm-sensors people) are not involved in maintaining
this driver in any way. So please remove the lm-sensors list (and
myself) from this discussion.

Thanks,
-- 
Jean Delvare
