From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH 0/4] SiI9022 HDMI encoder for AM4xxx boards
Date: Thu, 03 Jul 2014 16:34:46 +0200
Message-ID: <87k37u7bp5.fsf@lebrac.rtp-net.org>
References: <1404394800-18138-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1404394800-18138-1-git-send-email-tomi.valkeinen@ti.com> (Tomi
 Valkeinen's message of "Thu, 3 Jul 2014 16:39:56 +0300")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> Hi,

Hi,

>
> This series adds a driver for SiI9022 HDMI encoder, which is used on AM437x GP
> and AM43x EPOS boards.
>
> The series is based on the OMAPDSS HDMI infoframe series sent earlier, as the
> SiI9022 driver uses the new infoframe support.

Is there any small possibility to not make it an omap specific driver?
There are other boards with sii9022 out there. imx5x dev boards could
receive a daughter board with this chip (both sold by Freescale) and
efikamx platform has it too. I think that some old msm platforms has it
too.
I've not compared the code of the drivers and don't know how the sii9022
works but would be annoying to have 2 or more drivers for the same piece
of HW. imho, it would be nice if it could be avoided.

Thanks,
Arnaud
