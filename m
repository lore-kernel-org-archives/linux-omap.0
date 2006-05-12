From: ml@roese.nl
Subject: Re: problems compiling Das u-Boot 1.1.4 for omap osk 5912
Date: Fri, 12 May 2006 06:31:14 +0200
Message-ID: <200605120631.14864.ml@roese.nl>
References: <ae36f8040605111350u3ba2c1b6r1dc856db29aa3c87@mail.gmail.com>
	<ae36f8040605111439u690e08bbu7d6fdc876d99e597@mail.gmail.com>
	<ae36f8040605111450l72b35621v274d4e2cb7f6c1bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040605111450l72b35621v274d4e2cb7f6c1bb@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com, lvcargnini@ieee.org
List-Id: linux-omap@vger.kernel.org

On Thursday 11 May 2006 23:50, Lu=EDs Cargnini wrote:
> hi after downloaded the git tree version i try to compilate it and i
> received the following :
>

<snip>

> /opt/arm-linux/lib/gcc/arm-linux/4.0.3/libgcc.a(_divsi3.o) uses hardware
> FP, whereas u-boot uses software FP
> arm-linux-ld: failed to merge target specific data of file
> /opt/arm-linux/lib/gcc/arm-linux/4.0.3/libgcc.a(_divsi3.o)
> arm-linux-ld: ERROR:

What toolchain are you using? ELDK 4.0=20
(http://www.denx.de/wiki/DULG/ELDKAvailability) works here without problems.

Best regards,
Stefan
