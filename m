From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 4/5 v1] ASoC adds destination and source
	port for dma
Date: Tue, 30 Sep 2008 11:23:38 +0100
Message-ID: <20080930102337.GB19862@sirena.org.uk>
References: <dfeb90390809300305o69fc4c20wc54b0dfa27b84fd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <dfeb90390809300305o69fc4c20wc54b0dfa27b84fd9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun KS <arunks@mistralsolutions.com>
Cc: alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@nokia.com>, felipe.balbi@nokia.com
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 30, 2008 at 03:35:16PM +0530, Arun KS wrote:

> @@ -147,12 +147,14 @@ static int omap_pcm_prepare(struct
> snd_pcm_substream *substream)

Yup, these are definitely being word wrapped by your mailer so they
won't apply without massaging.  If you can't configure your normal MUA
to send them through cleanly you might want to look into git send-email
or the quilt equivalent both of which are specifically designed to
handle patches.

You can test this by mailing the patches to yourself and then trying to
apply them.

Anyway, the patch looks OK:

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
