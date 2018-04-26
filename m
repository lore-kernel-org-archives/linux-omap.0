From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 5/5] ASoC: omap: Remove OMAP_MUX dependency
 from Nokia N810 audio support
Date: Thu, 26 Apr 2018 16:01:51 +0300
Message-ID: <ee48f54c-9096-fe46-163b-c826b509b73d@ti.com>
References: <20180426115115.13744-1-peter.ujfalusi@ti.com>
 <20180426115115.13744-6-peter.ujfalusi@ti.com>
 <20180426125437.GG21755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180426125437.GG21755@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, aaro.koskinen@iki.fi, tony@atomide.com, Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

Mark,

On 2018-04-26 15:54, Mark Brown wrote:
> On Thu, Apr 26, 2018 at 02:51:15PM +0300, Peter Ujfalusi wrote:
>> From: Jarkko Nikula <jarkko.nikula@bitmer.com>
>>
>> Commit e9f5f1e45608 ("ARM: OMAP2+: Remove legacy mux code") removed
>> CONFIG_OMAP_MUX making impossible to build Nokia N810 audio support. Rem=
ove
>> this dependency so we can do at least build tests.
>>
>> Fixes: e9f5f1e45608 ("ARM: OMAP2+: Remove legacy mux code")
>> Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
>> ---
> =

> You're missing your signoff here.

I have not changed the patch itself, just picked it from the list to
include to the series. Afaik in this case my signoff is not needed.

Can you add my (or I can resend the series):
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
or
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
or
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

- P=E9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
