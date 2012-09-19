From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 00/14] MFD/ASoC/Input: twl4030-audio
	submodule DT support
Date: Wed, 19 Sep 2012 11:34:17 +0300
Message-ID: <50598389.6020600@ti.com>
References: <1347273992-9107-1-git-send-email-peter.ujfalusi@ti.com>
 <20120919002439.GB3647@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120919002439.GB3647@sortiz-mobl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Tero Kristo <t-kristo@ti.com>, alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dtor@mail.ru>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Samuel,

On 09/19/2012 03:24 AM, Samuel Ortiz wrote:
> Hi Peter,
> =

> On Mon, Sep 10, 2012 at 01:46:18PM +0300, Peter Ujfalusi wrote:
>> Hello,
>>
>> Generated on top of:
>> git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/omap
> I applied the first 8 patches, but I'd like to get Mark's ACK for the res=
t of
> the serie.
> Unless you're expecting Mark to take the whole thing, in which case you c=
an
> add my:
> =

> Acked-by: Samuel Ortiz <sameo@linux.intel.com>
> =

> to the MFD patches.
> Please let me know how you'd like to proceed.

If Mark is still OK with it I think it would be better to queue this series
via ASoC so we can keep them in one place (also I think patch 14 needs patc=
h 6
in order to not break x86/x86_64 allmodconfig).
On the other hand if they go separately (1-8 via MFD, 9-14 via ASoC) they w=
ill
meet in linux-next where this matters the most.

Thank you,
P=E9ter
