From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 03/20] OMAP: McBSP: Change wakeup signals
Date: Wed, 5 Aug 2009 10:40:36 +0300
Message-ID: <200908051040.36699.peter.ujfalusi@nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
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

On Thursday 30 July 2009 15:49:26 Valentin Eduardo (Nokia-D/Helsinki) wrote:
> Configure only XRDYEN and RRDYEN wakeup signals
> in order to get better power consumption.
>

> @@ -264,9 +264,7 @@
>  #define REOFEN			0x0004
>  #define RFSREN			0x0002
>  #define RSYNCERREN		0x0001
> -#define WAKEUPEN_ALL		(XEMPTYEOFEN | XRDYEN | XEOFEN | XFSXEN | \
> -				 XSYNCERREN | RRDYEN | REOFEN | RFSREN | \
> -				 RSYNCERREN)
> +#define WAKEUPEN_ALL		(XRDYEN | RRDYEN)

Or don't use the WAKEUPEN_ALL in the code, but replace it with (XRDYEN | =

RRDYEN)? It is confusing to use WAKEUPEN_ALL, which is actually _not_ enabl=
ing =

all wakeups.


-- =

P=E9ter
