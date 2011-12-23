From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 0/5] OMAP4: Fix CLKR/FSR mux for port with
	6 pin mode
Date: Fri, 23 Dec 2011 12:34:43 +0200
Message-ID: <4EF45943.3020302@bitmer.com>
References: <1324575106-17172-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1324575106-17172-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 12/22/2011 07:31 PM, Peter Ujfalusi wrote:
> Hello,
>
> This series will fix the CLKR/FSR signal mux configuration for OMAP4 devices.
> McBSP4 has 6 pin configuration on McBSP4 port while OMAP2/3 has the same
> capability on McBSP1 port.
> The API for mux control will be simplified for the mcbsp users (ASoC).
>
> The series depends on earlier series sent for mcbsp:
> OMAP4: McBSP: Fix clock reparenting
>
> I think the ASoC patch can go via linux-omap, since we do not have other changes
> for McBSP coming via sound tree.
>
Looks ok to me and you can have my ack if you plan to resend this after 
clock reparenting fix set. (Note small typo in 2/5 subject)

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
