From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] camera: c99 style structure
Date: Tue, 22 Nov 2005 00:50:04 -0800 (PST)
Message-ID: <20051122085004.71845.qmail@web32907.mail.mud.yahoo.com>
References: <20051121175231.GB7680@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20051121175231.GB7680@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, "Zhang, Jian" <jzhang@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Tony Lindgren <tony@atomide.com> wrote:

> * Zhang, Jian <jzhang@ti.com> [051121 07:20]:
> > Komal,
> > 
> > omap16xxcam.c is an OMAP specific file (OMAP1 camera I/F) instead
> of
> > board specific file. I like to keep omap16xxcam.c both board and
> sensor
> > independent. My suggestion is that moving the board code from the
> ov9640
> > sensor driver to board files and calling the board functions from
> the
> > sensor. So the sensor interface is intact.
> 
> I like this too.

Yes, but which board file is again a confusion. I don't think
board-hx.c is a good candidate for exporting functions from that. How
about gpio-expandar-omap.c itself? _or_ should we create a new file
under mach-omap1/2 to export this two powerup/down symbols?

---Komal Shah
http://komalshah.blogspot.com/


	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
