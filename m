From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCH] OMAP: McBSP: Do not use extensive spin
 locks for dma_op_mode
Date: Tue, 27 Oct 2009 13:07:23 +0200
Message-ID: <1256641643.30157.339.camel@eenurkka-desktop>
References: <1256641215-26131-1-git-send-email-peter.ujfalusi@nokia.com>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1256641215-26131-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 2009-10-27 at 12:00 +0100, Ujfalusi Peter (Nokia-D/Tampere)
wrote:
> The use of the spin lock, which supposed to protect the the
> dma_op_mode causing "INFO: inconsistent lock state" on
> playback start.
> Remove the spin locks around the dma_op_mode, when it's
> purpuse is to protect the dma_op_mode.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---

You may wish to double read the message above, as it's quite
confusing =)

Otherwise, that spinlocking is highly unnecessary and things are
far better without than with it. The only case it could be useful
is in SMPs, but OMAPs are not such quite yet - and when they
are, things will need to be re-though anyway.

- Eero
