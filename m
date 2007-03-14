From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: ARCH_OMAP243x vs. ARCH_OMAP2430
Date: Tue, 13 Mar 2007 19:01:19 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274298A29FE@dlee13.ent.ti.com>
References: <45F73916.2000504@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <45F73916.2000504@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>, OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

> But in the MUSB code as well as prcm-regs.h there are #ifdefs for
> OMAP243X.   Are there other 243x platforms in the wild, or should I
just
> convert these #ifdefs to 2430.  If converting is the right thing,
here's
> a patch.

Those 243X's are used in MV and TI trees.  I don't think the GIT one
used it.  They probably snuck in on your end or in previous pushes
candidates from others.

They all have to be the same for sure. Looks like a good thing to fix.

Regards,
Richard W.
