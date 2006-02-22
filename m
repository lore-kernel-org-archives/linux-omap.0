From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] Make H2 board file compile without irda warning
Date: Wed, 22 Feb 2006 08:16:50 -0800 (PST)
Message-ID: <20060222161650.26516.qmail@web32913.mail.mud.yahoo.com>
References: <9268368b0602220540n1cfd8a14oc83d805823821eb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9268368b0602220540n1cfd8a14oc83d805823821eb0@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Daniel Petrini <d.pensator@gmail.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

--- Daniel Petrini <d.pensator@gmail.com> wrote:

> 
>  Humm, my first idea was exactly like this but I tried to avoid
> another #ifdef..
>  So what about this new approach, which still avoids #ifdefs although
>  with expense of one flag ?
> 

I am now in confusion :). I like your patch too, but I thought that
adding #ifdef in board-* files is no harm. So, let's Tony speak :)

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
