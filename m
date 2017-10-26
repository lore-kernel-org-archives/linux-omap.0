From: =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>
Subject: Re: 4.13 (and probably all recent) kernels refuse to boot on one
 Nokia N950, work or another
Date: Thu, 26 Oct 2017 09:34:14 +0200
Message-ID: <949d6ed6-c82d-1f6a-ad0a-1e8af31592c5@gmail.com>
References: <20171025203459.GA22035@amd> <20171025212806.GA21504@atomide.com>
 <20171026071607.GB20634@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171026071607.GB20634@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On 10/26/2017 09:16 AM, Pavel Machek wrote:
> "Uart pins not muxed in NOLO" would certainly explain my problems. In
> 3.5.X, output works even in decompressor ("Uncompressing
> kernel... done, booting linux").

IIRC bootloader passes some additional settings for gpio that kernel
should apply (2.6 and 3.5 do that). I'm not sure if that would cause
booting to fail on that specific device, but can you compare kernel
params on S and P devices (by using 3.5.3 for P device)?

Filip
