From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: OMAP2420 H4 Touchscreen Driver
Date: Tue, 17 Oct 2006 01:59:18 -0700 (PDT)
Message-ID: <20061017085919.53926.qmail@web37902.mail.mud.yahoo.com>
References: <1161024122.2830.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1161024122.2830.4.camel@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: hkh@cypress.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Hingkwan Huen <hkh@cypress.com> wrote:

> Hello Everyone,
> 
> I am currently using 2.6.17 along with OPIE on the H4. However, I can
> never get the touchscreen working.
> Does anyone know if the touchscreen driver works for the H4? Any
> patch(es) available?
> 

There is no driver available for tsc2101-ts with latest SPI framework
yet for H4.

But you can refer this one: 
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005980.html

See, the it is very old patch and with spi code from TI tree. I would
suggest you to write new driver using SPI framework.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
