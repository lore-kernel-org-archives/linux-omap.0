From: "Deepak Barua" <dbbarua@gmail.com>
Subject: Tool Chain setting for OMAP 5912 board
Date: Thu, 11 Jan 2007 09:04:28 +0530
Message-ID: <b5a19cd20701101934k23cba1fak703661fe2d019f6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi ,
      I have used crosstool to compile a tool chain for the OMAP 5912
board the architecture i used is ARM v5 softfloat.

I want to know how to change the gcc and include files to library path
so i can use this cross compiler to compile a new kernel for the OMAP
board.

I tried changing /usr/bin/gcc to point to the new gcc and tried
changing the dynamic linker too but it corrupted my system and i had
to use a live cd to change it back to the original.

What should i do ...?

Regards
Deepak

-- 
Code Code Code Away
