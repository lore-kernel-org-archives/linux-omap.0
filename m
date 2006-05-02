From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap mmc build errors
Date: Tue, 2 May 2006 02:20:26 -0700
Message-ID: <20060502092025.GC24728@atomide.com>
References: <443BAD8C.4090005@indt.org.br>
	<20060413151756.47512.qmail@web32901.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060413151756.47512.qmail@web32901.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [060413 08:18]:
> --- Carlos Aguiar <carlos.aguiar@indt.org.br> wrote:
> 
> > Hi Komal and folks,
> > 
> > You have to apply a patch that Tony sent to the list 7 days ago. This
> > 
> > patch corrects the bugs mentioned above. Attached to this mail follow
> > 
> 
> You still need the attached patch on top of the Tony's patch to build
> it successfully.

I've just pushed that patch + fixed trying to ioremap a virtual address.
Seems to work now, can you test?

Tony
