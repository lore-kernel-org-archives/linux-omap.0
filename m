From: =?UTF-8?B?VmluY2VudCBTdGVobMOp?= <v-stehle@ti.com>
Subject: Re: [PATCH] ARM: OMAP5: select SCU
Date: Thu, 16 May 2013 15:10:29 +0200
Message-ID: <5194DAC5.9080203@ti.com>
References: <1368550638-2046-1-git-send-email-vincent.stehle@laposte.net> <51938169.4060109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51938169.4060109@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: =?UTF-8?B?VmluY2VudCBTdGVobMOp?= <vincent.stehle@laposte.net>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 05/15/2013 02:36 PM, Santosh Shilimkar wrote:
> OMAP5 doesn't need the SCU. So Nak for the patch.

Hi,

I agree that it is a pure link issue.

> I haven't noticed
> this earlier. Do you know which commit broke this ?

After some bisecting I arrived at this merge commit:

  5497e7b Merge branch 'late/fixes' into fixes

Indeed, if I revert it (-m 1) the result does link properly. I'll try to
isolate it further.

Best regards,

V.
