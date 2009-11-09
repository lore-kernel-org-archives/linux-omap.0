From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] OMAP: McBSP: Do not use extensive spin
 locks for dma_op_mode
Date: Mon, 9 Nov 2009 13:18:42 +0000
Message-ID: <20091109131842.GA25530@rakim.wolfsonmicro.main>
References: <1256641215-26131-1-git-send-email-peter.ujfalusi@nokia.com>
	<200910290835.51475.peter.ujfalusi@nokia.com>
	<20091029091524.a663e4e5.jhnikula@gmail.com>
	<200911090949.11680.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <200911090949.11680.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tony@atomide.com" <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 09, 2009 at 09:49:11AM +0200, Peter Ujfalusi wrote:

> Just want to bring up this thread.
> Should I resend the patch?

This is an arch/arm thing so I'd expect it to go via the OMAP tree.
