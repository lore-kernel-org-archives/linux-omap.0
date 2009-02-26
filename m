From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/3] ASoC: Add GPIO support for jack
	reporting interface
Date: Thu, 26 Feb 2009 10:52:10 -0800
Message-ID: <200902261052.10647.david-b@pacbell.net>
References: <2C7D3DF36ADFFC479B44490D912B616705EC8B1C03@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705EC8B1C03@dlee07.ent.ti.com>
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
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 25 February 2009, Lopez Cruz, Misael wrote:
> +=A0=A0=A0=A0=A0=A0=A0unsigned int gpio;

Use "int" not unsigned for such might-be-a-GPIO codes ...

> +=A0=A0=A0=A0=A0=A0=A0unsigned int irq;
> +=A0=A0=A0=A0=A0=A0=A0unsigned long irqflags;
> +=A0=A0=A0=A0=A0=A0=A0irq_handler_t handler;
> +=A0=A0=A0=A0=A0=A0=A0struct work_struct work;
> =A0};
> =A0
> +#define NO_JACK_PIN_GPIO=A0=A0=A0=A0=A0=A0=A0UINT_MAX

And any negative number to flag "no GPIO";
"-EINVAL" for example.


> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (pins[i].gpio !=3D NO_JA=
CK_PIN_GPIO) {

Make that:  if (gpio_is_valid(pins[i].gpio)) ...
