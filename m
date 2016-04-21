From: "J.D. Schroeder" <Linux.HWI@garmin.com>
Subject: Re: [PATCH] OMAPDSS: HDMI5: Change DDC timings
Date: Thu, 21 Apr 2016 11:04:23 -0500
Message-ID: <5718FA07.6080501@garmin.com>
References: <1461196973-20370-1-git-send-email-Linux.HWI@garmin.com>
 <5718E5F3.2080504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5718E5F3.2080504@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, misael.lopez@ti.com
Cc: "Lodes, Jim" <jim.lodes@garmin.com>, "J.D. Schroeder" <jay.schroeder@garmin.com>
List-Id: linux-omap@vger.kernel.org

On 04/21/2016 09:38 AM, Tomi Valkeinen wrote:
> Thanks, makes sense. Did you measure the rise & fall times? Do you get
> more or less exactly 100kHz with the new times?

Rise time is around 600 nsec and fall time is around 140 nsec. When the clock frequency is measured we get right at 100 kHz and the rise and fall times are negligible. When the HDMI certification test equipment is attached it is just slightly less than 100 kHz, which is okay. The HDMI specification states less than 100 kHz is acceptable not greater. If a particular system has slower rise and fall times then that should be okay also. This change ensures that we stay below 100 kHz regardless of  the rise and fall times.

>> Signed-off-by: Lodes, Jim <jim.lodes@garmin.com>
> 
> The email format should be
> 
> Firstname Lastname <firstname.lastname@foo.bar>

Yes. I'll fix the email and resubmit.
