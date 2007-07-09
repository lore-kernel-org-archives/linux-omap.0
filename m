From: Hunyue Yau <hyau@mvista.com>
Subject: Re: 2430 FB driver issues
Date: Mon, 9 Jul 2007 12:04:20 -0700
Message-ID: <200707091204.21320.hyau@mvista.com>
References: <782515bb0707031706l32231cbbv34a67572068b835f@mail.gmail.com>
	<468E9632.1080205@mvista.com>
	<Pine.LNX.4.64.0707081657410.5848@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <Pine.LNX.4.64.0707081657410.5848@utopia.booyaka.com>
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
To: linux-omap-open-source@linux.omap.com
Cc: Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

Paul,

It should have been working when it went it. The commit entry 
adding it should be:

commit 4ed427693dd7e0d4fd00a493988cefaa17accebc
Author: Hunyue Yau <hyau@mvista.com>
Date:   Fri May 25 15:33:08 2007 -0700

    OMAP: 2430SDP: Support LCD display as a FB device
    
    Add glue to control the 2430SDP LCD as a frame buffer device
    using the existing dispc.c driver under omapfb.
    
    Signed-off-by: Hunyue Yau <hyau@mvista.com>
    Signed-off-by: Kevin Hilman <khilman@mvista.com>
    Signed-off-by: Tony Lindgren <tony@atomide.com>

-- Hunyue

On Sunday 08 July 2007 16:01, Paul Walmsley wrote:
> Hi Kevin,
> 
> On Fri, 6 Jul 2007, Kevin Hilman wrote:
> 
> > FWIW, I have the same errors, but have not debugged it further.
> 
> You mentioned earlier that this code formerly worked for you before the 
> PRCM changes.  Do you have a commit ID or revision from a working version? 
> if so then perhaps Nishanth or someone else with a 2430 SDP might be able 
> to git-bisect to find which commit broke it.
> 
> 
> - Paul
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
