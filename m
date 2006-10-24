From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: Git tree updated to 2.6.19-rc2
Date: Tue, 24 Oct 2006 00:53:36 -0700 (PDT)
Message-ID: <20061024075336.58475.qmail@web37901.mail.mud.yahoo.com>
References: <20061023203925.GC11967@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061023203925.GC11967@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Tony Lindgren <tony@atomide.com> wrote:

> Hi all,
> 
> I've updated our git tree to 2.6.19-rc2. At least following have
> problems on omap1 (OSK):
> 
..

> - Aic23 NULL pointer exception
> 

Anything related to as discussed on davinci mailing list for I2C?

http://linux.omap.com/pipermail/davinci-linux-open-source/2006-October/001312.html

If that is the case, then please try adding zero-length transaction and
SMBUS_QUICK code as temporary hack.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
