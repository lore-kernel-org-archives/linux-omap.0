From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 11/20] OMAP: McBSP: Add link DMA mode
 selection
Date: Wed, 12 Aug 2009 14:45:47 +0300
Message-ID: <20090812144547.eb4bf7f2.jhnikula@gmail.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
	<20090805103900.5ad89efe.jhnikula@gmail.com>
	<200908051158.57440.peter.ujfalusi@nokia.com>
	<1FFEF31EBAA4F64B80D33027D4297760047F6AED01@NOK-EUMSG-02.mgdnok.nokia.com>
	<20090811090457.d89afd3e.jhnikula@gmail.com>
	<1249971481.16045.17.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1249971481.16045.17.camel@eenurkka-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext-eero.nurkkala@nokia.com
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 11 Aug 2009 09:18:01 +0300
Eero Nurkkala <ext-eero.nurkkala@nokia.com> wrote:

> > I would like to see this new threshold based transfer functionality to
> > be integrated so that projects can take the advantage of it and helps
> > generic PM development too but I don't want that it would cause any
> > regression now. Later on it is easy to switch threshold based transfer
> > to be the default for McBSP2 on OMAP3 but it's safer to keep current
> > mode default over one kernel release.
> > 
> 
> What regression are you addressing to? Of course in OMAP2s there could
> be issues I'm not aware of. But does this have any effect on them?
> (isn't this only OMAP3).
> 
A possible regression to a SW which is using McBSP2 on OMAP3.
There many of those boards.

The threshold based transfer will cause that omap_pcm_pointer will
loose a bit its accuracy. Probably irrelevant but still better to play
safe at least over one kernel release before making it default.

Return value prints from omap_pcm_pointer while playing
"aplay -f dat /dev/zero"

element:
614
669
691
712
734
755

threshold:
512
512
512
1024
1024
1536


-- 
Jarkko
