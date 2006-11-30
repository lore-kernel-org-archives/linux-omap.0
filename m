From: "andrzej zaborowski" <balrog-8Nh0/XqGfevYtjvyW6yDsg@public.gmane.org>
Subject: Multi-function chipset drivers
Date: Thu, 30 Nov 2006 20:26:34 +0100
Message-ID: <fb249edb0611301126l10e435ydcd290e467f49848@mail.gmail.com>
Reply-To: balrogg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-discuss-bounces-CN5wO63fgwogsBAKwltoeQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://handhelds.org/mailman/listinfo/kernel-discuss>,
	<mailto:kernel-discuss-request-CN5wO63fgwogsBAKwltoeQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://www.handhelds.org/hypermail/kernel-discuss/current>
List-Post: <mailto:kernel-discuss-CN5wO63fgwogsBAKwltoeQ@public.gmane.org>
List-Help: <mailto:kernel-discuss-request-CN5wO63fgwogsBAKwltoeQ@public.gmane.org?subject=help>
List-Subscribe: <https://handhelds.org/mailman/listinfo/kernel-discuss>,
	<mailto:kernel-discuss-request-CN5wO63fgwogsBAKwltoeQ@public.gmane.org?subject=subscribe>
Sender: kernel-discuss-bounces-CN5wO63fgwogsBAKwltoeQ@public.gmane.org
Errors-To: kernel-discuss-bounces-CN5wO63fgwogsBAKwltoeQ@public.gmane.org
To: Linux-OMAP <linux-omap-open-source-P3Mejjx7fphMeHKdZgrLhA@public.gmane.org>, Paul Sokolovsky <pmiscml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel-discuss-CN5wO63fgwogsBAKwltoeQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Linux-omap-open-source,

There has been a proposition of adding a light framework for Linux
drivers for chips with multiple different functions that are often
built into embedded boards. I've been reading the discussion that is
going on in kernel-discuss-CN5wO63fgwqpoNJhxZO3iw@public.gmane.org I'm just writing here to
make you aware of the proposition as the linux-omap-2.6 tree contains
at least drivers for the TSC2101 and TSC2102 chips that I know of and
only recently a driver for TWL4030 has been posted. Thus OMAP hackers
may have valuable comments on the proposed framework now while neither
the name nor the API is decided upon. These are the URLs of related
threads:

"[RFC] Shuffling drivers around"
http://www.handhelds.org/hypermail/kernel-discuss/20/2063.html

"SoC support and mainline"
http://www.handhelds.org/hypermail/kernel-discuss/21/2174.html

If you have ideas or critique please post under these threads.
Thanks,
Andrzej
