From: Matt Callow <mc-lists@tesco.net>
Subject: Re: Userspace GPIO
Date: Tue, 16 May 2006 10:08:27 +0100
Message-ID: <4469968B.3050802@tesco.net>
References: <09D3F703EF3B0A4CBE28449EA9F3D320477AD8@nicta-atp-mail.in.nicta.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <09D3F703EF3B0A4CBE28449EA9F3D320477AD8@nicta-atp-mail.in.nicta.com.au>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Marco Candiago wrote:
> Hello,
>
> We are developing with the Innovator 1510 2.6.12-rc2-omap1 kernel
> version.
>
> Going through the archives I see that a similar type of question has
> been a
> Asked regarding accessing the GPIO lines via user-space; the answer
> being just a link to the mailing list archives.
>
> With this kernel is there a convenient method of toggling the GPIO lines
> without having to resort to kernel space programming. With some other
> hardware I have seen using Linux, it is possible to access the GPIO
> lines via a /proc entry, however, I don't see that here.
>
>   
Since the GPIO lines are mapped into the ARM memory space, you can use a 
program like devmem2 to access the memory locations directly. Maybe not 
the most elegant solution but I've used the program successfully on an 
OMAP board. Try searching for devmem2.c in google.

Matt
