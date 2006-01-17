From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] keypad platform_data and 24xx support refresh
Date: Mon, 16 Jan 2006 21:25:24 -0800 (PST)
Message-ID: <20060117052524.58872.qmail@web32903.mail.mud.yahoo.com>
References: <1137435453.12289.51.camel@two.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1137435453.12289.51.camel@two.research.nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Juha Yrj=F6l=E4 <juha.yrjola@nokia.com> wrote:

>=20
> Only generic keypad drivers are supposed to live in omap-keypad.c.  I
> had the impression that using GPIOs is the standard way of
> implementing
> a keypad on OMAP2xxx CPUs (if you don't use an external keypad chip,
> that is).  Is this not the case?  Keypads handled by companion chips
> most likely will not share a lot of code with the OMAP-specific
> driver,
> so they naturally belong to a separate driver.

Fine, I agree with you and 2430 will have separate file in this case.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20
