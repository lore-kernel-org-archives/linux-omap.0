From: Komal Shah <komal_shah802003@yahoo.com>
Subject: RE: [PATCH] Fix OV9640 sensor and add h4 sensor power functions
Date: Tue, 14 Mar 2006 09:04:03 -0800 (PST)
Message-ID: <20060314170403.95804.qmail@web32903.mail.mud.yahoo.com>
References: <304D2A85A9643F4A991BDDF8D297BBA602949824@dlee05.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <304D2A85A9643F4A991BDDF8D297BBA602949824@dlee05.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Zhang, Jian" <jzhang@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- "Zhang, Jian" <jzhang@ti.com> wrote:

> Komal,
> 
> I have strncpy in my code and don't experience any issue. I don't
> know
> when it became strlcpy.
> 

Hmm, in your 2430 2.6.10 code (I hope this is your current tree) you
are copying into i2c_driver->name[32] not i2c_driver->driver.name,
which is the case in the latest git tree. So, I hope it is now clear
that why strlcpy/strncpy is failing in the latest tree.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
