From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: omap git tree inconsistency
Date: Sat, 8 Apr 2006 08:32:34 -0700 (PDT)
Message-ID: <20060408153234.54204.qmail@web32901.mail.mud.yahoo.com>
References: <20060407204358.GL21950@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060407204358.GL21950@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Tony Lindgren <tony@atomide.com> wrote:

> 
> Thanks for noting it! I've synced it with the mainline tree.
> 

Not complete yet !. Check drivers/i2c/chips in our tree and you will
find x1205.c driver, which is not present in the linus tree, as it was
moved to new rtc subsystem folder with new name rtc-x1205.c. So I
believe there will more locations like this...:)

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
