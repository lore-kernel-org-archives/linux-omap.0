From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/3] ARM: OMAP: SPI edge selection [was Re: Edge
	selecton on SPI bus]
Date: Tue, 16 May 2006 19:50:14 -0700
Message-ID: <200605161950.17041.david-b@pacbell.net>
References: <1147691115.32613.10.camel@mammoth.research.nokia.com>
	<200605151159.37793.david-b@pacbell.net>
	<1147817569.27886.54.camel@mammoth.research.nokia.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_p9oaE7Ssvykahnw"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <1147817569.27886.54.camel@mammoth.research.nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Imre Deak <imre.deak@nokia.com>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

--Boundary-00=_p9oaE7Ssvykahnw
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


> I think the devices worked so far with this buggy logic since I suspect
> a complementary problem in the TRM for the read edge selection HW flag.
> I checked this against devices that are known to be using a given SPI
> mode.

Hmm, I hope the attached GIF makes it through ... it shows the data
and clock signals and their variations pretty clearly, though you need
to understand that "out" means MOSI.

Agreed, the TRM is a bit opaque there.  There are three bits to
cover two basic protocol options:  sample edge (2x) which seems
to encode CPHA, and clock polarity which sure ought to be CPOL.  


> Also at least the ads7846 was using incorrectly SPI mode 0, since it's
> expecting writes on the falling / reads on the rising edge which maps to
> mode 1.

Seems right ... does that give you more consistent sample readings?


> I'm posting 3 patches to solve these issues.

They look OK to me.  I'd say to merge them to the OMAP tree; if no
problems turn up, I'll push the ads7846 patch along soonish.

- Dave

--Boundary-00=_p9oaE7Ssvykahnw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_p9oaE7Ssvykahnw--
