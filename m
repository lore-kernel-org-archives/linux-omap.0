From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 09/11] mfd: twl-core: Collect global variables behind
 one private structure (global)
Date: Tue, 12 Feb 2013 08:26:44 +0100
Message-ID: <5119EEB4.70508@ti.com>
References: <1358344439-23017-1-git-send-email-peter.ujfalusi@ti.com> <1358344439-23017-10-git-send-email-peter.ujfalusi@ti.com> <51154A7A.2010709@ti.com> <5115E3B9.6090100@ti.com> <51195301.8000606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51195301.8000606@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

On 02/11/2013 09:22 PM, Jon Hunter wrote:
> Good point. I just noticed that none of my omap2+ board were booting =
and
> on omap3/4 I was the panic in the twl code. I can't say that I checke=
d
> the panic on omap2, so may be that was another problem?

Do you have insights on the code path leading to a crash on OMAP3/4? I =
have
been running this code on several boards (BeagleBoard, Zoom2, PandaBoar=
d,
Blaze) and have not seen a crash.
But the fix is valid.

--=20
P=E9ter
