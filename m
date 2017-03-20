From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: omap: constify snd_soc_ops structures
Date: Mon, 20 Mar 2017 08:29:05 +0200
Message-ID: <20170320062905.GA4334@bitmer.com>
References: <1489845851-25364-1-git-send-email-bhumirks@gmail.com>
 <20170320005326.7gkckcy4rbgqij3h@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20170320005326.7gkckcy4rbgqij3h@earth>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Reichel <sre@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, peter.ujfalusi@ti.com, julia.lawall@lip6.fr, broonie@kernel.org, linux-omap@vger.kernel.org, Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 20, 2017 at 01:53:26AM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Sat, Mar 18, 2017 at 07:34:11PM +0530, Bhumika Goyal wrote:
> > Declare snd_soc_ops structures as const as they are only stored
> > in the ops field of a snd_soc_dai_link structure. This field is
> > of type const, so snd_soc_ops structures having this property
> > can be made const too.
> > 
> > Cross compiled the .o files for arm architecture.
> > 
> > Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> 
> I actually noticed this while working on Droid 4's sound support and
> added this to my TODO list - stroking it off again now :)
> 
> Reviewed-by: Sebastian Reichel <sre@kernel.org>
> 
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
