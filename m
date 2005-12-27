From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: Problem with flashing and/or starting UBoot with 2420
Date: Tue, 27 Dec 2005 02:30:58 -0800 (PST)
Message-ID: <20051227103058.1324.qmail@web32901.mail.mud.yahoo.com>
References: <3d3153f60512270021p638ce630w28819f7f910eef04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3d3153f60512270021p638ce630w28819f7f910eef04@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ola Helm <ola.hel@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Ola Helm <ola.hel@gmail.com> wrote:

> Hi,
> 
> Thanks for quick answering, unfortunately I haven't been able to mess
> around
> with board.
> 
> Yes, seems to be that boot is for NAND and not NOR. Thus it is
> actually
> opposite you said i.e.  I'm trying to flash & boot from NOR but the
> UBoot is
> for NAND.

Let me simplify my earlier statements:

o Link I had mentioned gives steps for Meneluas Board, flashing u-boot
to NOR flash i.e Booting from NOR.

o Flashing and booting from u-boot is a different story, as it requires
x-loader (you need to sign x-loader image) and different switch
positions. 

Switch positions are described in EVM user guide. Please refer that.

---Komal Shah
http://komalshah.blogspot.com/


	
		
__________________________________ 
Yahoo! for Good - Make a difference this year. 
http://brand.yahoo.com/cybergivingweek2005/
