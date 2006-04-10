From: prakhar vig <aquarian_133@yahoo.co.in>
Subject: IMG_jpeg_vlc-- How to use?
Date: Mon, 10 Apr 2006 11:16:48 +0100 (BST)
Message-ID: <20060410101648.75915.qmail@web8706.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi All,

I am trying to use a variable length coding library
present in IMGLIB, for my huffman encoding of a JPEG
file. I am facing certain problems i.e:

void IMG_jpeg_vlc(int *input_data, int *output_stream,
int type);

a)In this function length of output is data-dependent.
I am confused, what should be the size of an
output_stream array for 8x8 input data, and how many
bits of output_stream I have to write to a final JPEG
file.

If someone know something in this regard, please help
me.

Thanks And Regards
Prakhar



		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
