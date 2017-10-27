From: =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>
Subject: Re: 4.13 (and probably all recent) kernels refuse to boot on one
 Nokia N950, work or another
Date: Fri, 27 Oct 2017 14:58:16 +0200
Message-ID: <65ad0b63-cfae-f7ac-f916-32fd0c7c540a@gmail.com>
References: <20171025203459.GA22035@amd> <20171025212806.GA21504@atomide.com>
 <20171026091325.GA26929@amd> <20171026093115.4bc6ctxjx72ng7ld@earth>
 <20171026095734.GA10141@amd> <20171026120130.dicanunwcdmjntnb@earth>
 <20171027101905.GA4287@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171027101905.GA4287@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org


> If someone knows how to fix the backlight, it would still be useful.

In panel-dsi-cm.c it's set to maximum with

dsicm_dcs_write_1(ddata, DCS_BRIGHTNESS, 0xff);

Sebastian suggested the same but used 100 instead of 0xff, which might
be a bit too low. You can also add msleep(1000) after

dsicm_dcs_write_0(ddata, MIPI_DCS_SET_DISPLAY_ON);

to see if brightness gets overwritten, the whole display goes into sleep
mode, is turned off or similar somewhere down the line.

I'm still unable to make N9 panel to cooperate (despite having "the
right" clocks and able to send image to panel with
MIPI_DCS_WRITE_MEMORY_START/MIPI_DCS_READ_MEMORY_CONTINUE) so I hope
you'll have more luck than me!

Filip
