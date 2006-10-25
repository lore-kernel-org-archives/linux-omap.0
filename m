From: Tony Lindgren <tony@atomide.com>
Subject: Re: using __raw_read function
Date: Wed, 25 Oct 2006 21:04:30 +0300
Message-ID: <20061025180428.GI4852@atomide.com>
References: <CC7B089C59ED6841BAE28F1EA69A8543873721@EXCHDB.admin.wpi.edu>
	<20061024071924.15614.qmail@web55307.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20061024071924.15614.qmail@web55307.mail.re4.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Arnold <abo_gwapo@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Arnold <abo_gwapo@yahoo.com> [061024 10:20]:
> Hi All,
> 
> I am having problems writing a value to a specific
> register. I dont know if the one causing this problem
> is the __raw_readl function. I've tried to use all the
> registers in the I2C and I get the same problem. The
> values are not changed. Is there anyone who knows what
> the problem is? I dont think this is specific to I2C. 

Maybe you don't have I2C clock(s) enabled?

Tony
