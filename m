From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: multiple board files (was Re: [PATCH] OMAP: 2430SDP: Support
	LCDdisplay as a FB device)
Date: Fri, 25 May 2007 18:22:31 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47FF0C4C@dlee13.ent.ti.com>
References: <782515bb0705251601h7fe84dcbod53d74d46bdef28a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <782515bb0705251601h7fe84dcbod53d74d46bdef28a@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: nishanth menon <menon.nishanth@gmail.com>, Kevin Hilman <khilman@mvista.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

>apollon: 2 files
>Our mach-omap2 directory has 15 board files for 3 boards? Imagine
>having 10 different boards on omap2.. and each with multiple board
>files.. most of which cannot be reused... I am foreseeing
>non-readability there. IMHO having multiple files is not a scalable
>solution in the long run.. mebbe organising the board file to be
>readable makes sense..
>

We might not need a board file for every device, but it is necessary for =
few like MMC. It has lot of board specific data that if merged into a =
single file will cause lot of confusion.

Regards,
Khasim
