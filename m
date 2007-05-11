From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH] TWL4030 Keypad driver - incorporated review comments
Date: Thu, 10 May 2007 19:19:09 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47E26872@dlee13.ent.ti.com>
References: <782515bb0705101704s3d6d5120s4a5d2785eeeb1b3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <782515bb0705101704s3d6d5120s4a5d2785eeeb1b3b@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: nishanth menon <menon.nishanth@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Nishanth,

Thanks for comments.

>
>One Tiny comment to save a lot of bytes in git database header file ;):

Agreed,

>For the fields with more than one bits..
>#define BIT_TIME_OUT_REG1_LSB_TO_BITS             (8)
>MASK(OFFSET,NUMBITS)
>and Just define the offsets.. i'd say that will save some bytes of
>header file and bit more readable I think instead of figuring out _M
>means a mask... :D Compiler with optimization is be able to get the
>consts precompute and put them up as a single val..Here is my
>verification process:

I feel like not doing this, fundamental reason is we don't have an open =
TRM for TWL4030, this code is new to community and I don't want to =
confuse developers more. This though takes some kind of space is easy to =
understand and comment on. I can definitely revisit once I see some kind =
of usage of TWL4030 driver in community and having a public TRM to =
explain the same. Also I am just targeting drivers to get into some =
respectable form in GIT then we can improve them for more functionality =
and=20

>They all match as to the expected.. so there is my 2 cents... :)

They were worth a $ :)

Regards,
Khasim
