From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 0/9] Beaglebone-Black HDMI audio
Date: Fri, 8 Aug 2014 15:16:54 -0300
Message-ID: <20140808181654.GB16575@arch.cereza>
References: <cover.1407332062.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <cover.1407332062.git.jsarha@ti.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jyri Sarha <jsarha@ti.com>
Cc: devicetree@vger.kernel.org, mturquette@linaro.org, peter.ujfalusi@ti.com, t-kristo@ti.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, zonque@gmail.com, liam.r.girdwood@linux.intel.com, tony@atomide.com, broonie@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello Jyri,

On 06 Aug 04:47 PM, Jyri Sarha wrote:
> The code has a functional dependency to:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg108199.html
> =

> Without the above patch the audio card does not probe.
> =

> The code has been rebased on top of Linux 3.16 merged with =

> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> with http://www.mail-archive.com/linux-omap@vger.kernel.org/msg108199.html
> cherry-picked on top.
> =

> All patches have gone trough some cleaning up since the RFC version of
> these patches over half a year ago.
> =


To my surprise, this worked out of the box. Did some simple tests with mpg1=
23
and mplayer.

Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Thanks a lot!
-- =

Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
