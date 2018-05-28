From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] ASoC: omap: sdma-pcm: add module
	license
Date: Mon, 28 May 2018 11:55:05 +0300
Message-ID: <517750ec-5db4-fecb-3a26-271b2007b4aa@ti.com>
References: <20180525160248.4135506-1-arnd@arndb.de>
 <20180525173531.GP4828@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180525173531.GP4828@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 2018-05-25 20:35, Mark Brown wrote:
> On Fri, May 25, 2018 at 06:02:31PM +0200, Arnd Bergmann wrote:
>> Kbuild warns that we should have a MODULE_LICENSE() tag in the new modul=
e:
>>
>> WARNING: modpost: missing MODULE_LICENSE() in sound/soc/omap/snd-soc-sdm=
a.o
> =

> This doesn't apply against current code, please check and resend.

'ASoC: omap: sdma-pcm: Fix modpost warning' is already applied which
adds the missing MODULE_LICENSE()

- P=E9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
