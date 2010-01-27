From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCHv2 1/6] ASoC: OMAP: data_type and sync_mode
	configurable in audio dma
Date: Wed, 27 Jan 2010 09:06:52 +0200
Message-ID: <201001270906.52775.peter.ujfalusi@nokia.com>
References: <2256F256009DAA4CBE661E9F41EAC84B8C43A8AD@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B8C43A8AD@dlee01.ent.ti.com>
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
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ext Candelaria Villareal, Jorge" <x0107209@ti.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

On Saturday 23 January 2010 01:14:59 ext Candelaria Villareal, Jorge wrote:
> From: Misael Lopez Cruz <x0052729@ti.com>
> =

> Allow client drivers to set the data_type (16, 32) and the
> sync_mode (element, packet, etc) of the audio dma transferences.
> =

> McBSP dai driver configures it for a data type of 16 bits and
> element sync mode.

Since the mcbsp code itself is hardwired for 16bit samples (at the moment),=
 I =

think it would be better to add constraint in omap-pcm.c to make it explici=
t =

that only S16_LE is supported.

-- =

P=E9ter
