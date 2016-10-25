From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [RFC] shutdown machine when li-ion battery goes below 3V
Date: Tue, 25 Oct 2016 12:57:37 +0200
Message-ID: <20161025105737.GL12154@pali>
References: <20161024212250.GA31336@amd>
 <20161024212932.uhjz752z2cy5hohl@atomide.com>
 <20161024214152.GA32310@amd>
 <201610242348.47484@pali>
 <20161025102435.GA6916@amd>
 <20161025105320.GK12154@pali>
 <20161025105604.GA25855@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161025105604.GA25855@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org

On Tuesday 25 October 2016 12:56:04 Pavel Machek wrote:
> Take a look at code. Health is not read from hardware unless battery
> is calibrated.

Then it is bug. EDVF should be accepted also when battery is not
calibrated.

-- 
Pali Rohár
pali.rohar@gmail.com
