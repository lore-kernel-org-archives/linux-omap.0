From: Peter Barada <peterb@logicpd.com>
Subject: Problem using UART3 on Logic Torpedo w/2.6.32
Date: Thu, 18 Nov 2010 16:05:27 -0500
Message-ID: <4CE59517.7060408@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 174-46-170-154.static.twtelecom.net ([174.46.170.154]:44397
	"EHLO edprlnx06.logicpd.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760406Ab0KRVOD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 16:14:03 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Peter Barada <peter.barada@logicpd.com>

All,

I have a 2.6.32 kernel based on the L23.i3.3 kernel (2.6.32) from TI, 
and I've run into an interesting problem with UART3 (maps to /dev/ttyS1 
on the Torpedo board).

On the host I have it hooked up to /dev/ttyS1, so I turn on CTS/RTS and 
set the baudrate by:

host$ stty 115200 crtscts < /dev/ttyS1

And the same on the target:

OMAP-35x$ stty 115200 crtscts < /dev/ttyS1

To force the board to throttle the serial I slowed down the console to 
19200:

OMAP-35x$ stty 19200 < /dev/ttyS0

On the target console I capture the data from the host (and show it on 
the serial port):

OMAP-35x$ cat < /dev/ttyS1 | tee /tmp/x

and on the host send the data:

host$ dd if=/dev/urandom count=100 bs=1024 | hexdump -C > /tmp/x
host$ cat /tmp/x > /dev/ttyS1

I'd expect to see something like the following on the target:

00000000  35 2c a6 97 23 35 95 9a  fb 91 6d 6e ce f8 32 d7  
|5,..#5....mn..2.|
00000010  6b 0b cf 66 e6 3a b4 55  91 5f 86 8f 41 c9 49 76  
|k..f.:.U._..A.Iv|
00000020  e6 cf fa 0a 0e db 69 0c  db 14 6b 76 62 4c 5b 9e  
|......i...kvbL[.|
00000030  98 1b 5f 30 16 d6 ed 96  dc d7 f1 3b 59 a0 ec ac  
|.._0.......;Y...|
00000040  86 8c 9b 28 21 b8 a0 98  ed cf 96 39 15 a4 7b 9e  
|...(!......9..{.|
00000050  bf 01 aa 09 1a 12 1f c3  49 b3 92 73 00 84 52 de  
|........I..s..R.|
00000060  c0 d3 4b 1d ca 84 04 ea  60 ef 7f b2 63 36 eb 5e  
|..K.....`...c6.^|
00000070  28 0c 20 2a 86 a2 36 bb  c7 c0 27 da 87 c8 8b 1e  |(. 
*..6...'.....|
00000080  5d b7 04 b3 2c 0b 29 f4  8d 4f 5f fe 90 b0 1b 96  
|]...,.)..O_.....|
00000090  b8 82 94 ae 92 37 31 03  dc 1b c3 c0 38 b1 16 77  
|.....71.....8..w|

Instead I see:

OMAP-35x# head /tmp/x
00000000  35 2c a6 97 23 6b 0b ca  fb 91 6d 6e ce f8 32 d6 8f 
41.#5....mn..2.|
00000010  .Iv|
00f 66 e6 3a b4 55  91 5f 8669 0c  c9 49 76  
|k..f.:.U._..A.|.....000020  e6 cf
fa 0a 0e db 1b 5f  db 14 6b 76 62 4c 5b 9e  b 59 a.i...kvbL[.|
00000030  98.|
000030 16 d6 ed 96  dc d7 f1 3b 59 e0 ec ac  
|.._0.......;Y.....(!..0040  86 8c
9b 28 21 b8 a0 98 09d cf 96 39 15 a4 7b 9e  |.00 84 ....9..{.|
00000050  bf 01000000 1a 12 1f c3  49 b3 92 73 a  60 52 de  
|........I..s..R.|
.....`60  c0 d3 4b 1d ca 84 04 e0 2a 8ef 7f b2 63 36 eb 5e  |..7 c8 
8b...c6.^|
00000070  28 0c 20000806 a2 36 bb  c7 c0 27 da 87 8d 4f 1e  |(. 
*..6...'.....|
00.)..O_  5d b7 04 b3 2c 0b 29 f4 ae 92  5f fe 90 b0 1b 96  |]...,.).6 
7.....|
00000090  b8 82 94 00a0  37 31 03  dc 1b c3 c0 38 b1 7c 77  
|.....71.....8..w|

Looking deeper:

OMAP-35x# hexdump -C /tmp/x | head
00000000  30 30 30 30 30 30 30 30  20 20 33 35 20 32 63 20  |00000000  
35 2c |
00000010  61 36 20 39 37 20 32 33  20 36 62 20 30 62 20 63  |a6 97 23 6b 
0b c|
00000020  61 20 20 66 62 20 39 31  20 36 64 20 36 65 20 63  |a  fb 91 6d 
6e c|
00000030  65 20 66 38 20 33 32 20  64 36 20 38 66 20 34 31  |e f8 32 d6 
8f 41|
00000040  2e 23 35 2e 2e 2e 2e 6d  6e 2e 2e 32 2e 7c 0a 30  
|.#5....mn..2.|.0|
00000050  30 30 30 30 30 31 30 20  20 2e 49 76 7c 0a 30 30  |0000010  
.Iv|.00|
00000060  66 20 36 36 20 65 36 20  33 61 20 62 34 20 35 35  |f 66 e6 3a 
b4 55|
00000070  20 20 39 31 20 35 66 20  38 36 36 39 20 30 63 20  |  91 5f 
8669 0c |
00000080  20 63 39 20 34 39 20 37  36 20 20 7c 6b 2e 2e 66  | c9 49 76  
|k..f|
00000090  2e 3a 2e 55 2e 5f 2e 2e  41 2e 7c 2e 2e 2e 2e 2e  
|.:.U._..A.|.....|

However if I instead use UART2 and replicate the above steps, all is 
well.  I've looked at the serial signals and CTS/RTS are responding as 
expected.  I tried switching drivers from the 8250 to the OMAP_SERIAL, 
and the results look the same.

Any ideas what is happening?

-- 
Peter Barada
peterb@logicpd.com

