From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/2] ASoC: omap-mcpdm: Support for handling
	pdmclk
Date: Fri, 16 Nov 2018 09:58:15 +0200
Message-ID: <4d5e6dbc-5123-34ed-8f7d-c61e822b001d@ti.com>
References: <20181114124631.4586-1-peter.ujfalusi@ti.com>
 <20181115223012.GR2089@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181115223012.GR2089@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, tony@atomide.com, "H. Nikolaus Schaller" <hns@goldelico.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

On 2018-11-16 00:30, Mark Brown wrote:
> On Wed, Nov 14, 2018 at 02:46:29PM +0200, Peter Ujfalusi wrote:
> =

>> I have separated the binding document update and the driver patch and al=
so
>> added the return value check for the clk_prepare_enable() as per Mark's =
comment.
> =

> I guess this depends on your other series for pm_qos - it's fine itself
> but doesn't apply, I'm leaving the pm_qos series for a bit longer in
> case there's more reviews.

Yes, I moved this on top of the pm_qos, I think I have mentioned that in
the cover letter.

Yes again, let's wait for Nikolaus to test the pm_qos w/o CPU_IDLE and
hopefully 4.19 against the scratchy tenth of seconds observed. Fwiw on
omap5-uevm I was able to reproduce bad audio quality with CPU_IDLE which
is fixed by the pm_qos patch.

- P=E9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
