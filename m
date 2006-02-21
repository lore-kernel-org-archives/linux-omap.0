From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] Make H2 board file compile without irda warning
Date: Tue, 21 Feb 2006 13:28:38 -0800 (PST)
Message-ID: <20060221212838.67357.qmail@web32905.mail.mud.yahoo.com>
References: <9268368b0602210954x5b7bdd28p7b630fe83a52647b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9268368b0602210954x5b7bdd28p7b630fe83a52647b@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Daniel Petrini <d.pensator@gmail.com>, OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

--- Daniel Petrini <d.pensator@gmail.com> wrote:

> Hi,
> 
> The board file for H2 is generating a warning if compiled without
> InfraRed selection.
> 
> This patch changes the location where the function
> h2_transceiver_mode
> is assigned to structure h2_irda_data, thereby preventing the
> warning.

True, the warning will be generated, but I added that check considering
that transceiver_mode function will be active only if we are
successfully able to request that GPIO. So, I am _not_ sure, but it is
better to #ifdef around the h2_transceiver_mode(...) function. What do
you think?

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
