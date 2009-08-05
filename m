From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 11/20] OMAP: McBSP: Add link DMA mode
	selection
Date: Wed, 5 Aug 2009 11:58:57 +0300
Message-ID: <200908051158.57440.peter.ujfalusi@nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
	<20090805103900.5ad89efe.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090805103900.5ad89efe.jhnikula@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 05 August 2009 10:39:00 ext Jarkko Nikula wrote:
> On Thu, 30 Jul 2009 15:49:34 +0300
>
> Eduardo Valentin <eduardo.valentin@nokia.com> wrote:
> > From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> >
> > +
> > +	return sprintf(buf, "%d\n", dma_op_mode);
>
> It would be good to handle this as an ascii like e.g /sys/power/state
> does. "element", "threshold" or "frame". A number value doesn't tell
> much (for me when testing).

At least when reading it it would be nice to have asci, like "element (0)", =

"threshold (1)"...

>
> I would say the default mode for the omap34xx should be also element as
> it keeps the omap_pcm_pointer behavior the same than currently and
> avoids possible regression.

Yes, the default mode should be the element mode in my opinion as well.

-- =

P=E9ter
