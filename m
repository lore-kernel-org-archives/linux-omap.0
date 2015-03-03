From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-pcm: Allow only formats with 1,
 2, and 4 byte physical size
Date: Tue, 3 Mar 2015 14:45:28 +0200
Message-ID: <54F5ACE8.2050702@ti.com>
References: <1425382133-17120-1-git-send-email-jsarha@ti.com>
 <54F59DE1.2010406@ti.com> <20150303122208.GA28158@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20150303122208.GA28158@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: linux-omap@vger.kernel.org

On 03/03/2015 02:22 PM, Jarkko Nikula wrote:
> On Tue, Mar 03, 2015 at 01:41:21PM +0200, Peter Ujfalusi wrote:
>> On 03/03/2015 01:28 PM, Jyri Sarha wrote:
>>> sDMA support only transfer elements with 1, 2, and 4 byte physical
>>> size. Initialize the pcm driver accordingly.
>>
>> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>
>>>
>>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>>> ---
>>>  sound/soc/omap/omap-pcm.c | 21 ++++++++++++++++++++-
>>>  1 file changed, 20 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
>>> index f4b05bc..e49ee23 100644
>>> --- a/sound/soc/omap/omap-pcm.c
>>> +++ b/sound/soc/omap/omap-pcm.c
>>> @@ -39,7 +39,7 @@
>>>  #define pcm_omap1510()	0
>>>  #endif
>>>  =

>>> -static const struct snd_pcm_hardware omap_pcm_hardware =3D {
>>> +static struct snd_pcm_hardware omap_pcm_hardware =3D {
>>>  	.info			=3D SNDRV_PCM_INFO_MMAP |
>>>  				  SNDRV_PCM_INFO_MMAP_VALID |
>>>  				  SNDRV_PCM_INFO_INTERLEAVED |
>>> @@ -53,6 +53,24 @@ static const struct snd_pcm_hardware omap_pcm_hardwa=
re =3D {
>>>  	.buffer_bytes_max	=3D 128 * 1024,
>>>  };
>>>  =

>>> +/* sDMA supports only 1, 2, and 4 byte transfer elements. */
>>> +static void omap_pcm_limit_supported_formats(void)
>>> +{
>>> +	int i;
>>> +
>>> +	for (i =3D 0; i < SNDRV_PCM_FORMAT_LAST; i++) {
>>> +		switch (snd_pcm_format_physical_width(i)) {
>>> +		case 8:
>>> +		case 16:
>>> +		case 32:
>>> +			omap_pcm_hardware.formats |=3D (1LL << i);
>>> +			break;
>>> +		default:
>>> +			break;
>>> +		}
>>> +	}
>>> +}
>>> +
> =

> I wonder why these are set in a loop instead of setting formats statically

omap-pcm as such can work with any formats which has 1, 2 or 4 bytes layout=
 in
memory (and not only S16_LE, S32_LE).
sDMA can not handle 3byte words so we can not handle those with omap-pcm. In
contrast eDMA for example can handle 1, 2, 3 and 4 w/o issue.

> and why this is needed after commit 60e21d287344 ("ASoC: omap: Don't set
> unused struct snd_pcm_hardware fields")?

Hrm, interesting. We also have:
2d38df128321 (ASoC: generic-dmaengine-pcm: Prepare formats mask for valid
physical sample sizes)

Which does the same thing for the generic dmaengine pcm users.

Actually the information from the omap_pcm_hardware is copied to runtime.hw
via snd_soc_set_runtime_hwparams() call, so it is not ignored.

We need this masking to be done here since the omap-pcm is still mostly cus=
tom
code and do not plug easily to the generic code (ie, not at all).

-- =

P=E9ter
