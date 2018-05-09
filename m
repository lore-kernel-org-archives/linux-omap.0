From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 0/7] ASoC: omap: Deprecate omap-pcm for
	sdma-pcm
Date: Wed, 9 May 2018 12:36:53 +0300
Message-ID: <1419d845-39a8-f755-4faa-119eba427fc0@ti.com>
References: <20180507085000.6414-1-peter.ujfalusi@ti.com>
 <20180509082640.GR13402@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180509082640.GR13402@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

Mark,

On 2018-05-09 11:26, Mark Brown wrote:
> On Mon, May 07, 2018 at 11:49:53AM +0300, Peter Ujfalusi wrote:
>> Hi,
>>
>> Changes since v3:
>> - Rebased to make sure it applies cleanly (I had one local Kconfig patch)
> =

> What have you rebased against?  It's still not applying patch 2 cleanly
> (indeed due to a change in snd/soc/davinci/Kconfig which my git doesn't
> have any SHA1s for, plus some conflicts in davinci-mcasp.c).
> =


Hrm, true, I do have Kconfig change in davinci/Kconfig (sanitizing the
prompt)

and a local changes for mcasp driver itself.

I'll resend the mcasp patch and the last patch (to remove the omap-pcm).

Sorry,
- P=E9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
