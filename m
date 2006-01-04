From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: How to play a raw audio file in OMAP1510
Date: Wed, 4 Jan 2006 01:18:59 -0800 (PST)
Message-ID: <20060104091859.75472.qmail@web32901.mail.mud.yahoo.com>
References: <ade4abe50601040059s49d8b649x493f0b35a023fd21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ade4abe50601040059s49d8b649x493f0b35a023fd21@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: RAVI SHANGAR <ravishangar@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- RAVI SHANGAR <ravishangar@gmail.com> wrote:

> We used the kernel 2.6.12. While building it, we enabled the sound
> driver as
> a built in Module.
>=20
> How can we play a raw file?

#cat audio.raw > /dev/sound/dsp (if devfs enabled) or
#cat audio.raw > /dev/dsp


---Komal Shah
http://komalshah.blogspot.com/


	=09
__________________________________________=20
Yahoo! DSL =96 Something to write home about.=20
Just $16.99/mo. or less.=20
dsl.yahoo.com=20
